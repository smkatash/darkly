# Unvalidated Redirects and Forwards

Unvalidated redirects and forwards are possible when a web application accepts untrusted input that could cause the web application to redirect the request to a URL contained within untrusted input. By modifying untrusted URL input to a malicious site, an attacker may successfully launch a phishing scam and steal user credentials.

Because the server name in the modified link is identical to the original site, phishing attempts may have a more trustworthy appearance. Unvalidated redirect and forward attacks can also be used to maliciously craft a URL that would pass the application's access control check and then forward the attacker to privileged functions that they would normally not be able to access.

These vulnerabilities are commonly used in:

- **Phishing attacks** – Users are redirected to a fake login or malware site under the guise of a trusted domain.
- **Bypassing access controls** – If internal forwards are used for routing, attackers may exploit them to gain unauthorized access to protected functionality.

Because the base domain often appears legitimate (`https://example.com/redirect?to=malicious.com`), users are more likely to trust and click the link.

## Example
```http
https://example.com/redirect?url=http://malicious.com
```

## Mitigations
To prevent unvalidated redirects and forwards:
- Avoid using user-controlled input to determine redirect or forward destinations.
- Use a whitelist of allowed URLs or routes for any redirection behavior.
- Validate and sanitize all input, especially query parameters that control navigation.
- Redirect to relative paths only, not absolute URLs, unless verified.
- Display a warning or confirmation page before redirecting the user to an external site.
- Log redirect activity for audit and detection of unusual patterns.
- Educate users to be cautious of unexpected redirects and always verify destination URLs.

## References
- [Unvalidated Redirects and Forwards](https://cheatsheetseries.owasp.org/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.html)

## Exercise
Through inspection of the footer, modification of url has been attempted.
```
<footer id="footer">
				<div class="container">
					<ul class="icons">
						<li><a href="index.php?page=redirect&site=facebook" class="icon fa-facebook"></a></li>
						<li><a href="index.php?page=redirect&site=twitter" class="icon fa-twitter"></a></li>
						<li><a href="index.php?page=redirect&site=instagram" class="icon fa-instagram"></a></li>
					</ul>
					<ul class="copyright">
						<a href="?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f"><li>&copy; BornToSec</li></a>
					</ul>
				</div>
</footer>
```
The social media link has been replaced with malicious web-page and submited