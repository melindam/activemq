activemq Cookbook CHANGELOG
===========================
This file is used to list changes made in each version of the activemq cookbook.

v1.3.6 (melindam)
-----------------
- changing node set values for attributes
- including systemd for CentOS7 systemctl stop/start command

v1.3.5 (melindam)
------------------
- update to version 5.11.0
- included `run_as_user` so as it will not have to be run as root user
- included simple authenticated user / password for connecting to queues

v1.3.4 (Development)
-------------------

v1.3.3 (2015-04-03)
------------------

- Metadata includes `issues_url` and `source_url`

v1.3.2 (2014-04-23)
-------------------
- [COOK-4557] activemq cookbook default mirror url is broken


v1.3.0
------
### Bug
- **[COOK-3309](https://tickets.opscode.com/browse/COOK-3309)** - Fix service (re)start command
- **[COOK-2846](https://tickets.opscode.com/browse/COOK-2846)** - Add support for openSUSE
- **[COOK-2845](https://tickets.opscode.com/browse/COOK-2845)** - Support differing versions of `wrapper.conf`

v1.2.0
------
### New Feature
- **[COOK-1777](https://tickets.opscode.com/browse/COOK-1777)** - Add stomp integration

v1.1.0
------
- [COOK-2816] - update version to 5.8.0
- [COOK-2817] - resolve foodcritic warning

v1.0.2
------
- [COOK-800] - activemq cookbook should install 5.5.1 by default
- [COOK-872] - activemq home directory isn't explicitly created
