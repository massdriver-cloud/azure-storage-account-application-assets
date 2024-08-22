### Azure Storage Account

Azure Storage Accounts provide a scalable, durable, and highly available object storage solution. They can be used to store a variety of data, including blobs, files, queues, tables, and disks, supporting both REST API and SMB clients.

#### Design Decisions

This module is tailored to set up an Azure Storage Account with specific configurations:
- **Storage Account Kind**: `StorageV2` is selected to allow for better performance and feature set.
- **Performance Tier**: `Standard` tier is used for cost efficiency while providing adequate performance.
- **Access Tier**: `Hot` tier is configured for frequently accessed data, providing faster access times.
- **Replication**: Supports various replication strategies defined by `replication_type` variable for high availability.
- **Data Retention Policies**: Configurations for blob and container deletion policies enhance data protection.
- **Monitoring and Alerts**: Built-in monitoring to check availability and latency, with automated alerts for quick notifications and resolutions.

### Runbook

#### Unable to Access Blob Storage

If you're experiencing issues accessing your blob storage, ensure that your access credentials are correct and that the storage account is reachable.

Check access keys:
```sh
az storage account keys list --resource-group <resource-group-name> --account-name <storage-account-name>
```

Verify if the correct key is being used.
```sh
export AZURE_STORAGE_KEY=<one-of-the-listed-keys>
```

Check endpoint connectivity:
```sh
curl -I https://<storage-account-name>.blob.core.windows.net
```

You should get a response status code 200 or 403 (depending whether the account allows public access or requires authentication).

#### Blob Data Read/Write Issues

Verify if the appropriate roles are assigned to the user or application:
```sh
az role assignment list --assignee <user-or-service-principal-id>
```

Ensure the appropriate roles like `Storage Blob Data Reader` or `Storage Blob Data Contributor` are assigned.

#### High E2E Success Latency

If experiencing high end-to-end success latency, check storage account metrics:
```sh
az monitor metrics list --resource <storage-account-id> --metric SuccessE2ELatency
```

Analyze the output to identify patterns or times of high latency.

#### High Server Latency

For high server latency issues, review the server-side latency metrics:
```sh
az monitor metrics list --resource <storage-account-id> --metric SuccessServerLatency
```

Check whether the latency is occasional or consistent. If consistent, consider performance tier upgrade or reviewing the workload pattern.

#### Low Availability

If your storage account has low availability, validate the availability metric:
```sh
az monitor metrics list --resource <storage-account-id> --metric Availability
```

Check for recent incidents or maintenance activities that might have impacted availability:
```sh
az storage account show --name <storage-account-name> --resource-group <resource-group-name>
```

