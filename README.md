




[![Massdriver][logo]][website]

# azure-storage-account-application-assets

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]

<!--
##### STILL NEED TO GET SLACK WORKING ###
[!["Slack Community"](%s)][slack]
-->


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

- **`redundancy`** *(object)*: Cannot contain additional properties.
  - **`data_protection`** *(boolean)*: Default: `False`.
  - **`replication_type`** *(string)*: The type of replication to use for the storage account.
    - **One of**
      - Local-redundant storage
      - Zone-redundant storage
      - Geo-redundant storage
      - Geo-zone-redundant storage
      - Geo-redundant storage (read-access)
      - Geo-zone-redundant storage (read-access)
- **`storage`** *(object)*: Cannot contain additional properties.
  - **`region`** *(string)*: The region in which the storage account will be located (cannot be changed after deployment).
    - **One of**
      - East US
      - North Central US
      - South Central US
      - West US
## Examples

  ```json
  {
      "__name": "Development",
      "redundancy": {
          "data_protection": true,
          "data_protection_days": 7
      }
  }
  ```

  ```json
  {
      "__name": "Production",
      "redundancy": {
          "data_protection": true,
          "data_protection_days": 365
      }
  }
  ```

<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`azure_service_principal`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*: Cannot contain additional properties.
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

  - **`specs`** *(object)*: Cannot contain additional properties.
<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
## Properties

- **`azure_storage_account`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*: Cannot contain additional properties.
    - **`authentication`** *(object)*: Cannot contain additional properties.
      - **`connection_string`** *(string)*: Azure Storage Account Connection String authentication.

        Examples:
        ```json
        "DefaultEndpointsProtocol=https;AccountName=localdevstorage0000;AccountKey=1234abcd=;EndpointSuffix=core.windows.net"
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

    - **`infrastructure`** *(object)*: Cannot contain additional properties.
      - **`ari`** *(string)*: Azure Resource ID.

        Examples:
        ```json
        "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
        ```

    - **`security`** *(object)*: Azure Security Configuration. Cannot contain additional properties.
      - **`iam`** *(object)*: IAM Roles And Scopes. Cannot contain additional properties.
        - **`^[a-z/-]+$`** *(object)*: Cannot contain additional properties.
          - **`role`**: Azure Role.

            Examples:
            ```json
            "Storage Blob Data Reader"
            ```

          - **`scope`** *(string)*: Azure IAM Scope.
  - **`specs`** *(object)*: Cannot contain additional properties.
    - **`azure`** *(object)*: . Cannot contain additional properties.
      - **`region`** *(string)*: Select the Azure region you'd like to provision your resources in.
        - **One of**
          - East US
          - North Central US
          - South Central US
          - West US
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
