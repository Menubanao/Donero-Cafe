/**
 * Donero Cafe - Backend Configuration
 * 
 * This file contains the configuration for connecting to the Supabase backend.
 * To enable Supabase, uncomment the script tags in index.html and admin.html
 * and use these credentials to initialize the client.
 */

const SUPABASE_CONFIG = {
    URL: 'https://vuqvokufivgtevpvppcd.supabase.co',
    KEY: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ1cXZva3VmaXZndGV2cHZwcGNkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzIwMTgyNzAsImV4cCI6MjA4NzU5NDI3MH0.VJ7m8CUBexVdJRinN82Bor3IEM4JEqadE0Rm1_IyvfE'
};

// Export configuration if using modules, otherwise it will be available globally if included via <script>
if (typeof module !== 'undefined' && module.exports) {
    module.exports = SUPABASE_CONFIG;
}
