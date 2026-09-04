/**
 * md-to-pdf configuration — Fluent MedOps branded documents
 * Type-only wordmark; Source Serif 4 / Archivo / IBM Plex Mono via Google Fonts.
 */
module.exports = {
  pdf_options: {
    format: 'Letter',
    margin: { top: '22mm', right: '18mm', bottom: '20mm', left: '18mm' },
    printBackground: true,
    displayHeaderFooter: true,
    headerTemplate: `
      <div style="width:100%; font-family: Georgia, 'Times New Roman', serif; font-size:9px; padding:6px 18mm 0 18mm; box-sizing:border-box;">
        <div style="display:flex; justify-content:space-between; align-items:baseline; border-bottom:1px solid #1F8A8A; padding-bottom:5px;">
          <span style="font-size:11px; font-weight:600; color:#0B1F2A;">Fluent<span style="color:#1F8A8A;">&nbsp;MedOps</span></span>
          <span style="font-family:'Courier New',monospace; font-size:7.5px; letter-spacing:.12em; text-transform:uppercase; color:#7A8A90;">Revenue cycle &middot; For accountant review</span>
        </div>
      </div>
    `,
    footerTemplate: `
      <div style="width:100%; font-family:'Courier New',monospace; font-size:7.5px; padding:0 18mm; box-sizing:border-box; color:#7A8A90;">
        <div style="display:flex; justify-content:space-between; border-top:1px solid #D8D2C7; padding-top:5px; letter-spacing:.04em;">
          <span>FLUENT MEDOPS &middot; CONFIDENTIAL &middot; PREPARED FOR THE PRACTICE ACCOUNTANT &amp; TAX ADVISOR</span>
          <span>Page <span class="pageNumber"></span> / <span class="totalPages"></span></span>
        </div>
      </div>
    `
  },

  stylesheet: [
    'https://fonts.googleapis.com/css2?family=Source+Serif+4:opsz,wght@8..60,400;8..60,600;8..60,700&family=Archivo:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500&display=swap',
    '/app/templates/fluent-medops.css'
  ],

  document_title: 'Fluent MedOps Document',

  marked_options: { gfm: true, breaks: false, smartypants: true },

  launch_options: {
    executablePath: process.env.PUPPETEER_EXECUTABLE_PATH || '/usr/bin/chromium',
    args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage']
  }
};
