# Security policy

## Disclosure policy

In case you find a security issues with this docker image, please reach out to me at security@homecentr.io and provide 5 business days to release a fixed version.

## Security update policy

Known security issues will be published in GitHub repository's Security / Security advisories. The security issues are published according to the output from Phonito.io scan. 

Due to the fact that this image is based on Ubuntu (Alpine unfortunately does not contain the libraries required for Draw.io rendering), there are other low severity vulnerabilities detected by Snyk and other apps which currently do not have a solution (e.g. the package does not have a newer version which would fix the problem). Due to the number of issues, this repository will report/treat as failure vulnerabilities with severity High or Critical.

## Automated processes

The Docker image is scanned for vulnerabilities every 24 hours using [Phonito.io](https://phonito.io/?b=a) and [Snyk](https://snyk.io). You can see the scan status under the actions tab / Regular Docker image vulnerability scan.

The dependencies are automatically scanned using [Dependabot](https://dependabot.com/). Dependencies are regularly updated. You can check for pending dependency updates by listing open Pull requests with the "dependencies" label.