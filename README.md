[![Massdriver][logo]][website]

# azure-storage-account-application-assets

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]


Azure Blob storage is optimized for storing unstructured data. This storage solution is ideal for storing any files produced and consumed by your application internally.


---

## Design

For detailed information, check out our [Operator Guide](operator.mdx) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->
## Properties

- **`account`** *(object)*
  - **`region`** *(string)*: The region where the storage account will be created. **Cannot be changed after deployment**.
- **`monitoring`** *(object)*
  - **`mode`** *(string)*: Enable and customize Function App metric alarms. Default: `AUTOMATED`.
    - **One of**
      - Automated
      - Custom
      - Disabled
- **`redundancy`** *(object)*
  - **`data_protection`** *(integer)*: Set the number of days to allow data recovery if data is deleted (minimum 1, maximum 365). Minimum: `1`. Maximum: `365`. Default: `7`.
  - **`replication_type`** *(string)*
    - **One of**
      - Local-redundant storage
      - Geo-redundant storage
      - Geo-redundant storage (read-access)
      - Zone-redundant storage
      - Geo-zone-redundant storage
      - Geo-zone-redundant storage (read-access)
  - **`zone_redundancy`** *(boolean)*: Enable zone redundancy for the storage account. **Cannot be changed after deployment**. Default: `False`.
<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`azure_service_principal`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`client_id`** *(string)*: A valid UUID field.

      Examples:
      ```json
      "123xyz99-ab34-56cd-e7f8-456abc1q2w3e"
      ```

    - **`client_secret`** *(string)*
    - **`subscription_id`** *(string)*: A valid UUID field.

      Examples:
      ```json
      "123xyz99-ab34-56cd-e7f8-456abc1q2w3e"
      ```

    - **`tenant_id`** *(string)*: A valid UUID field.

      Examples:
      ```json
      "123xyz99-ab34-56cd-e7f8-456abc1q2w3e"
      ```

  - **`specs`** *(object)*
<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
## Properties

- **`azure_storage_account_blob`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`authentication`** *(object)*
      - **`sas_token`** *(string)*
    - **`infrastructure`** *(object)*
      - **`ari`** *(string)*: Azure Resource ID.

        Examples:
        ```json
        "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
        ```

      - **`endpoint`** *(string)*: Azure Storage Account endpoint authentication. Cannot contain additional properties.

        Examples:
        ```json
        "https://storageaccount.blob.core.windows.net/"
        ```

        ```json
        "http://storageaccount.file.core.windows.net"
        ```

        ```json
        "abfs://filesystem.accountname.dfs.core.windows.net/"
        ```

        ```json
        "https://storageaccount.privatelink01.queue.core.windows.net/"
        ```

    - **`security`** *(object)*: Azure Security Configuration. Cannot contain additional properties.
      - **`iam`** *(object)*: IAM Roles And Scopes. Cannot contain additional properties.
        - **`^[a-z]+[a-z_]*[a-z]$`** *(object)*
          - **`role`**: Azure Role.

            Examples:
            ```json
            "Storage Blob Data Reader"
            ```

          - **`scope`** *(string)*: Azure IAM Scope.
  - **`specs`** *(object)*
    - **`azure`** *(object)*: .
      - **`region`** *(string)*: Select the Azure region you'd like to provision your resources in.
<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/azure-storage-account-application-assets/issues) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]

<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg
[docs]: https://docs.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=azure-storage-account-application-assets&utm_content=docs
[website]: https://www.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=azure-storage-account-application-assets&utm_content=website
[github]: https://github.com/massdriver-cloud?utm_source=github&utm_medium=readme&utm_campaign=azure-storage-account-application-assets&utm_content=github
[slack]: https://massdriverworkspace.slack.com/?utm_source=github&utm_medium=readme&utm_campaign=azure-storage-account-application-assets&utm_content=slack
[linkedin]: https://www.linkedin.com/company/massdriver/?utm_source=github&utm_medium=readme&utm_campaign=azure-storage-account-application-assets&utm_content=linkedin



[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/azure-storage-account-application-assets.svg?style=for-the-badge
[contributors_url]: https://github.com/massdriver-cloud/azure-storage-account-application-assets/graphs/contributors
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/azure-storage-account-application-assets.svg?style=for-the-badge
[forks_url]: https://github.com/massdriver-cloud/azure-storage-account-application-assets/network/members
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/azure-storage-account-application-assets.svg?style=for-the-badge
[stars_url]: https://github.com/massdriver-cloud/azure-storage-account-application-assets/stargazers
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/azure-storage-account-application-assets.svg?style=for-the-badge
[issues_url]: https://github.com/massdriver-cloud/azure-storage-account-application-assets/issues
[release_url]: https://github.com/massdriver-cloud/azure-storage-account-application-assets/releases/latest
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/azure-storage-account-application-assets.svg?style=for-the-badge
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/azure-storage-account-application-assets.svg?style=for-the-badge
[license_url]: https://github.com/massdriver-cloud/azure-storage-account-application-assets/blob/main/LICENSE


[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2
[twitter_url]: https://twitter.com/massdriver?utm_source=github&utm_medium=readme&utm_campaign=azure-storage-account-application-assets&utm_content=twitter
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[discourse_url]: https://community.massdriver.cloud?utm_source=github&utm_medium=readme&utm_campaign=azure-storage-account-application-assets&utm_content=discourse
[discourse_shield]: https://img.shields.io/badge/join-Discourse-black.svg?style=for-the-badge&logo=discourse&color=000000
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->
