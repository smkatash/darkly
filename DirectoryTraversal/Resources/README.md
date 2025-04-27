# Path Traversal Attack

A **Path Traversal** attack (also known as *directory traversal*, *dot-dot-slash*, *directory climbing*, or *backtracking*) allows an attacker to access files and directories stored outside the intended web root folder. By manipulating input parameters with sequences like `../` or using absolute file paths, attackers can potentially read sensitive files from the server's file system.

Examples of target files might include:

- Application source code  
- Configuration files  
- User data  
- System files (e.g., `/etc/passwd` on Linux or `boot.ini` on Windows)

It's important to note that file access is still governed by the system's OS-level permissions—files that are locked or restricted will still be inaccessible unless the attacker also has sufficient privileges.

## Mitigations

To defend against path traversal attacks:

- **Never trust user input** for file paths. Always validate and sanitize it on the server side.
- **Use a whitelist of permitted file names or directories** instead of accepting dynamic paths.
- **Restrict file access to a specific base directory**, and ensure the application never allows paths to escape this directory.
- **Normalize and canonicalize file paths** before accessing the filesystem, to resolve `../` and symbolic links.
- **Avoid passing user input directly into file APIs** like `open()` or `readFile()`.
- **Use built-in security functions or libraries** that abstract file access safely.
- **Apply least privilege principles** to the web server and application processes, limiting access to only required directories.
- **Log file access events**, especially for unexpected or unauthorized path attempts.

## References
- [OWASP: Path Traversal Attack](https://owasp.org/www-community/attacks/Path_Traversal)

## Exercise
While inspection path existing path combinations of index.php?page=Placeholder, we get notification WTF?
It hinted that a vulnaribility can be hidden there, to check the possibility a script is run that has all most combinations of user data, system file etc. for different servers.

- [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings)

Following path has notified the flag  and has been detected:
index.php?page=../../../../../../../etc/passwd