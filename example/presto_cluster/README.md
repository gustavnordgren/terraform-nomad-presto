# Presto cluster example
The current directory contains terraform related files that use the module in `../../`. The example module spins up presto in [cluster mode](../conf/nomad/presto.hcl) having one worker.
It uses vault as the shared secret provider. For more details check [main.tf](./main.tf).

## Modules in use
| Modules       | version       |
| ------------- |:-------------:|
| [terraform-nomad-postgres](https://github.com/fredrikhgrelland/terraform-nomad-postgres) | 0.2.0 |
| [terraform-nomad-minio](https://github.com/fredrikhgrelland/terraform-nomad-minio) | 0.2.0 |
| [terraform-nomad-hive](https://github.com/fredrikhgrelland/terraform-nomad-hive) | 0.2.0 |

## Services
![img](./terraform-nomad-presto.png)

## Example of uploaded files
This example uses the following file types found in the [example/resources/data](../resources/data) folder:
- csv
- json
- avro
- protobuf

Directory `/resources` contains data example with will be loaded to technology stack in the current example.

```text
├── resources
│   ├── data/           # files that are uploaded to minio
│   ├── query/          # presto query example for uploaded data
│   └── schema/         # schema(s) for data serializers/deserializers
├── ...
```
