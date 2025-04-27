# Unrestricted File Upload

Uploaded files represent a significant risk to applications. The first step in many attacks is to get malicious code onto the target system. Once uploaded, the attacker only needs to find a way to execute that code. File uploads provide an easy method to complete the first part of this process.

The consequences of unrestricted file uploads can vary widely and may include:

- Complete system takeover  
- Overloaded file system or database  
- Forwarding attacks to back-end systems  
- Client-side attacks (e.g., XSS)  
- Website defacement  

These outcomes depend on how the application handles uploaded files and, more importantly, where those files are stored.

There are two main classes of problems when handling file uploads:

1. **File Content** – The file itself may contain malicious payloads that execute when opened or processed.
2. **File Metadata** – Metadata such as file names and paths are typically supplied by the transport mechanism (e.g., HTTP multipart form-data). If not properly validated, this data can trick the application into overwriting critical files or saving files in unintended locations.

## Mitigations
To protect against unrestricted file upload vulnerabilities, implement the following strategies:

- **Allow only specific file types**: Enforce a strict whitelist of acceptable file extensions and MIME types.
- **Verify file content**: Inspect the file's actual content (e.g., magic numbers) instead of trusting the file extension alone.
- **Rename uploaded files**: Save uploaded files using randomized or hashed filenames to prevent overwriting or access via predictable URLs.
- **Store files outside the web root**: Prevent direct access to uploaded files by keeping them in directories not served by the web server.
- **Disable execution permissions**: Ensure the upload directory doesn't allow execution of files (e.g., disable `exec` in Apache or NGINX).
- **Limit file size**: Prevent denial-of-service attacks by setting maximum upload size limits.
- **Scan files with antivirus software**: Run uploaded files through malware detection tools on the server.
- **Check file metadata**: Sanitize file names and paths to avoid directory traversal and unintended overwrites.
- **Use strong access controls**: Restrict who can upload files and who can access uploaded content, especially if it’s user-generated.

## References
- [Unrestricted File Upload](https://owasp.org/www-community/vulnerabilities/Unrestricted_File_Upload)

## Exercise
For this exercise, after scrupulous investigation of the upload page and after some tests of uploading different files, it has been identified that filename can be modified and request goes through. This means, that the file-type checking in upload has not be secured. 

```http
Content-Disposition: form-data; name="uploaded"; filename="script.php"
Content-Type: image/jpeg
```
