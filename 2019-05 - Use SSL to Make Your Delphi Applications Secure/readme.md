# Use SSL to make your Delphi applications secure. For free.

Delphi is so well known for building desktop applications and for its database functionality that it might be easy to overlook its long history of server and multi-tier support. Everything from simple networking components to MIDAS/DataSnap to web applications to XML web services to RAD Server and more.

But now, with all of this network traffic, security becomes an issue. How do you keep your sensitive information safe from prying eyes? Unfortunately, proper security can be difficult, time consuming and expensive

But it doesn’t have to be.

We’ll use the Delphi Community Edition to create some server applications and other free tools like OpenSSL and Let’s Encrypt to let us talk to them securely.

---

### Answers to some questions asked at the meeting

**Q**: Does Indy require a special Indy-only build of the OpenSSL SLLs? Those found on the Fulgan site, for example?

**A**: No. Indy can use different versions of OpenSSL built for Windows. I tested the demo applications from the presentation against the [Indy (Fulgan)](https://indy.fulgan.com/SSL/), [ICS](http://wiki.overbyte.eu/wiki/index.php/ICS_Download#Download_OpenSSL_Binaries_.28required_for_SSL-enabled_components.29) and [Shining Light](http://slproweb.com/products/Win32OpenSSL.html) hosted builds of OpenSSL.
However, Indy doesn't support OpenSSL 1.1.x yet, which has interface changes. It requires the 1.0.2 DLLs.

**Q**: If Indy doesn't require a special version, then why do they make their own build?

**A**: Both Indy and ICS host builds of OpenSSL that remove the dependency on the VC++ runtime.

**Q**: Can you cerate and renew Let's Encrypt SSL certificates using Delphi?

**A**: Yes. ICS now includes a free [TSslX509Certs component](https://community.letsencrypt.org/t/new-acme-client-for-embarcadero-rad-studio-delphi-and-c-development-tools/77610) made by Magenbta Systems and there is the commercial [DelphiACME](https://github.com/tothpaul/DelphiACME) that you can use to automate Let's Encrypt instead of using external tools.

---
### Resources:
* [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter)
---
* [Internet packet monitoring components](https://www.magsys.co.uk/delphi/magmonsock.asp) - Magenta Systems
* [ICS - Internet Component Suite](http://www.overbyte.eu) - Overbyte
---
* [FastMM - FullDebugMode](https://sergworks.wordpress.com/2018/06/06/fastmm4-fulldebugmode-setup-guide)
* [Nexus Quality Suite - CodeWatch](https://www.nexusdb.com/support/index.php?q=codewatchfeatures)
* [Deleaker](https://www.deleaker.com)
---
* [OpenSSL](https://www.openssl.org/)
* [OpenSSL Binaries](https://www.openssl.org/community/binaries.html)
* [Understanding and generating OpenSSL config files](https://www.phcomp.co.uk/Tutorials/Web-Technologies/Understanding-and-generating-OpenSSL.cnf-files.html)
* [OpenSSL Cookbook](https://www.feistyduck.com/books/openssl-cookbook)
---
* [Let's Encrypt](https://letsencrypt.org/)
* [Client Applications](https://letsencrypt.org/docs/client-options)
* [ZeroSSL](https://zerossl.com/)
---
* [CloudFlare](https://www.cloudflare.com/)
* [Caddy Server](https://caddyserver.com/)
---
* [Free domain names](https://palash.tk/How-To-Get-A-Free-Domain)
* [TDUG test web site](http://tdug.co.nf)
