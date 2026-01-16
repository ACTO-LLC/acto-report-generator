/**
 * md-to-pdf configuration for A CTO branded status reports
 * https://github.com/simonhaenisch/md-to-pdf
 */

module.exports = {
  // Page settings
  pdf_options: {
    format: 'Letter',
    margin: {
      top: '25mm',
      right: '20mm',
      bottom: '25mm',
      left: '20mm'
    },
    printBackground: true,
    displayHeaderFooter: true,
    headerTemplate: `
      <div style="width: 100%; font-size: 9px; padding: 5px 20mm 0 20mm; box-sizing: border-box;">
        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #1a365d; padding-bottom: 5px;">
          <img src="data:image/png;base64,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" alt="A CTO" style="height: 16px; max-width: 70px;" />
          <span style="color: #666;">A CTO Document</span>
        </div>
      </div>
    `,
    footerTemplate: `
      <div style="width: 100%; font-size: 8px; padding: 0 20mm; box-sizing: border-box;">
        <div style="display: flex; justify-content: space-between; color: #666; border-top: 1px solid #ddd; padding-top: 5px;">
          <span>A CTO - We Help Business Get Business Done</span>
          <span>Page <span class="pageNumber"></span> of <span class="totalPages"></span></span>
        </div>
      </div>
    `
  },

  // Stylesheet
  stylesheet: '/app/templates/status-report.css',

  // Document settings
  document_title: 'A CTO Document',

  // Marked options for markdown parsing
  marked_options: {
    gfm: true,
    breaks: false,
    smartypants: true
  },

  // Launch options for Puppeteer
  launch_options: {
    executablePath: process.env.PUPPETEER_EXECUTABLE_PATH || '/usr/bin/chromium',
    args: [
      '--no-sandbox',
      '--disable-setuid-sandbox',
      '--disable-dev-shm-usage'
    ]
  }
};
