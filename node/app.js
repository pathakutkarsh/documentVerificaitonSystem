import { createClient } from '@supabase/supabase-js'

// Create a single supabase client for interacting with your database
const supabase = createClient('https://mjhtcnoxatlhfnduhupy.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1qaHRjbm94YXRsaGZuZHVodXB5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODM3NDMyNzAsImV4cCI6MTk5OTMxOTI3MH0.YdHD5jmJI4-cvAYt5pl5i5PomYy9YyPog69t7c_zDi0')

supabase
  .channel('any')
  .on('postgres_changes', { event: '*', schema: 'public', table: 'documents' }, payload => {
    console.log('Change received!', payload)
  })
  .subscribe()