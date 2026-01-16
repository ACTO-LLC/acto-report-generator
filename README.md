# A CTO Report Generator

Docker-based tool for converting Markdown documents to PDF with A CTO branding.

## Building the Image

```bash
# From this directory
docker build -t acto-report-generator .
```

## Usage

### On Windows (Git Bash / WSL)

```bash
# Use //c/ prefix for Windows paths
docker run --rm -v "//c/path/to/your/docs:/data" acto-report-generator document.md

# Example:
docker run --rm -v "//c/source/strategy-planning/playbooks:/data" acto-report-generator information-security-policy.md
```

### On Linux/Mac

```bash
docker run --rm -v "$(pwd):/data" acto-report-generator document.md
```

### Custom Output Filename

```bash
docker run --rm -v "//c/path/to/docs:/data" acto-report-generator input.md custom-output.pdf
```

## Output

- PDF is generated in the same directory as the input markdown file
- Uses A CTO branding and styling defined in `pdf-config.js`

## Files

- `Dockerfile` - Docker image definition
- `entrypoint.sh` - Script that runs the PDF conversion
- `pdf-config.js` - Puppeteer/PDF configuration and styling
- `templates/` - Logo and CSS for branding

## Troubleshooting

### "Input file not found" error
- Ensure you're using the correct path format for your OS
- On Windows with Git Bash, use `//c/` prefix (not `C:/` or `/c/`)
- Verify the file exists in the mounted directory

### Image not found
Build the image first:
```bash
docker build -t acto-report-generator .
```
