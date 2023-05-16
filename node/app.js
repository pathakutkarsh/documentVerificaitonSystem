import { createClient } from '@supabase/supabase-js'
import { File } from 'node:buffer';
import { spawn } from 'child_process';
import fs from 'fs'
// Create a single supabase client for interacting with your database
const supabase = createClient('https://mjhtcnoxatlhfnduhupy.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1qaHRjbm94YXRsaGZuZHVodXB5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODM3NDMyNzAsImV4cCI6MTk5OTMxOTI3MH0.YdHD5jmJI4-cvAYt5pl5i5PomYy9YyPog69t7c_zDi0')

var buffer;
async function listentoDb() {
  const documents = supabase.channel('custom-insert-channel')
    .on(
      'postgres_changes',
      { event: 'INSERT', schema: 'public', table: 'documents' },
       (payload) => {

         setTimeout(async function() {
          console.log(payload.new['file_name']);
          var fileName = await downloadDataFromStorage(payload.new['file_name'])
          executePowerShell(fileName)
  
        }, 20000);

      }
    )
    .subscribe((status) => {
      console.log(status)
    }
    )
}

async function downloadDataFromStorage(filename) {
  var { data, error } = await supabase
    .storage
    .from('documents')
    .download("/uploaded/" + filename)
  const blob = data;
    buffer = Buffer.from(await blob.arrayBuffer());
  var file = await fs.promises.writeFile('D:\\Projects\\DocumentVerificationSystem\\temp\\' + filename, buffer).then(console.log("file Saved"));
  return filename
}

function executePowerShell(filename) {
  var child = spawn("powershell.exe", ["python", "D:\\Projects\\DocumentVerificationSystem\\python\\main.py", 'D:\\Projects\\DocumentVerificationSystem\\temp\\' + filename]);
  child.stdout.on("data", function (data) {
    // console.log("Powershell Data: " + data);
    var splitdata = String(data).split('\n')
    uploadDataToStoage(splitdata[0].trim()).finally(() => {
      updateDatabaseUsingImageName(filename,splitdata[0].trim(),splitdata[1].trim(),splitdata[2].trim())
    })
  });
  child.stderr.on("data", function (data) {
    console.log("Powershell Errors: " + data);
  });
  child.on("exit", function () {
    console.log("Powershell Script finished");
  });
  child.stdin.end(); //end input
}


async function uploadDataToStoage(filename) {
  // var buffer = fs.readFileSync(filename);
  console.log(filename);
  var { data, error } = await supabase
    .storage
    .from('documents')
    .upload("/edited/" + filename, buffer).finally(() => { console.log("File Uploaded");})
}

async function updateDatabaseUsingImageName(fileName, editedFileName, isverified, isvalidated) {
  const { error } = await supabase
    .from('documents')
    .update({
      'edited_image_name': editedFileName,
      'is_verified': isverified,
      'is_validated': isvalidated
    })
    .eq('file_name', fileName)
}
listentoDb()