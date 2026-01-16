# PDF Generation Instructions

When asked to generate a PDF from a markdown file, use the `acto-report-generator` Docker container.

## Command

```bash
docker run --rm -v "<directory-containing-markdown>:/data" acto-report-generator <filename.md> [output.pdf]
```

## Parameters

- **Volume mount**: Mount the directory containing the markdown file to `/data`
- **Input file**: The markdown filename (relative to the mounted directory)
- **Output file** (optional): Custom output filename; defaults to `<input>.pdf`

## Examples

```bash
# Generate PDF with default name (document.pdf)
docker run --rm -v "C:\source\docs:/data" acto-report-generator document.md

# Generate PDF with custom output name
docker run --rm -v "C:\source\docs:/data" acto-report-generator document.md custom-name.pdf
```

## Notes

- The PDF is created in the same directory as the input markdown file
- The container applies A CTO branding (header, footer, styling)
- If the image doesn't exist, build it first:
  ```bash
  docker build -t acto-report-generator "C:\source\acto-report-generator"
  ```
