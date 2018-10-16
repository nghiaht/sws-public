


## Ideas

We run the express app provided in this source in order to pass the challenge by Let's Encrypt.
On VPS, cloud, or remote server, run this express app and set up domain TEMPORARILY (the one you want to generate SSL certs) A/CNAME to that server (port 80).

Should open two terminal, one for running certbot commands and one for running the Express app.


* Terminal 1: Install & Run Certbot
 
  * Follow https://itnext.io/node-express-letsencrypt-generate-a-free-ssl-certificate-and-run-an-https-server-in-5-minutes-a730fbe528ca

  * Stop after entering the domain name, the terminal output would show the challenge

* We update app/index.js by adding a specific router (the Express way)

    ```
    Example:

    // This is the sample
    // Replace the content after /acme-challange/<content1>
    // And the response res.send(<content2>)
    // by your challenge requirement
    app.get('/.well-known/acme-challenge/XuHDyYGSjaQNhRcxfGuUlrjCnRzqHCsHE8PM-fdN0Uo', (req, res) => {
        res.send('XuHDyYGSjaQNhRcxfGuUlrjCnRzqHCsHE8PM-fdN0Uo.owlbvjxo2wcd-H7GYFhW3fWqwZ9RIanVFAqRvVq7Z8g');
    })
    ```

* Terminal 2: Run the express app (node index.js).
* Terminal 1: Proceed by pressing enter as directed.
* Now certbot will make a request to your domain, and because your domain is pointing to the server that is running this express app (port 80)
so we could pass the challenge and get the certs.
* Certs are located at /etc/letsencrypt.

* Let's Encrypt certs are free for 90 days, for renewal check out certbot docs (running simple commands).

