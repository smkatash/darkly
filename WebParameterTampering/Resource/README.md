# Web Parameter Tampering

Web Parameter Tampering is an attack technique that involves manipulating parameters exchanged between a client and server in order to modify application data such as:

- User credentials and permissions  
- Product price and quantity  
- Access control variables  
- Transaction-related data  

These parameters are commonly found in:
- **Cookies**  
- **Hidden form fields**  
- **URL query strings**  
- **HTTP headers**

## Mitigations
To defend against Web Parameter Tampering:
- **Validate all parameters on the server side**, regardless of how trustworthy they appear.
- **Use strong access controls** to prevent unauthorized users from modifying sensitive parameters.
- **Avoid storing sensitive data in client-controllable parameters**, like hidden fields or query strings.
- **Implement integrity checks**, such as cryptographic hashes or tokens, to ensure parameter values are not tampered with.
- **Use HTTPS** to encrypt traffic and prevent interception or modification in transit.
- **Conduct regular security testing** using tools like Burp Suite or OWASP ZAP to detect tampering vulnerabilities.

## References
- [Web Parameter Tampering](https://owasp.org/www-community/attacks/Web_Parameter_Tampering)

## Exercise
On index.php?page=survey, change value="10" (maximum possible value).
Modify sujet=1&valeur=11 and submit to get the flag.