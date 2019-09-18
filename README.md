# ProFTPD: SFTP Configured
Configured SFTP Server with ProFTPD.

## Usage
### Basic
In container, sftp port is 2222.

    docker run -d --name sftp1 -p 10022:2222 nobrin/proftpd-sftp

### Persistent data
Mount the data directory for actual use.

Create data directory.

    mkdir mydata

Start container with the created path.

    docker run -d --name sftp1 -p 10022:2222 -v $(pwd)/mydata:/etc/proftpd/sftp nobrin/proftpd-sftp

At starting up, the container generate empty ftppasswd and ftpgroup files, authorized_keys directory. And SSH host keys are generated.

- ftppasswd -- Virtual users for sftp
- ftpgroup -- Virtual groups for sftp

## Create a user/group
User/group can be created with ftpasswd(proftpd-utils) on running container.
Location of the ftppasswd/ftpgroup is presented in the example below.

    docker exec -ti sftp1 ftpasswd --passwd --file=/etc/proftpd/sftp/ftppasswd --name user1 --uid=1000 --gid=1000 --home=/var/lib/ftp/user --shell=/sbin/nologin
    docker exec -ti sftp1 ftpasswd --group --file=/etc/proftpd/sftp/ftpgroup --name=siteuser --gid=1000

Because of setting with "DefaultRoot ~", user home directory will be chroot'ed. The data directory to be used must be mounted.

## Customize
### Environment Variables
- SFTP_TZ
  - Timezone(ex. Asia/Tokyo) (optional)
- SFTP_AUTH_METHODS
  - SFTPAuthMethods(publickey, password, or publickey+password) (default:publickey) (optional)

### Configuration file
If you want modifty configuration file(s), mount your file to these places.

- sftp.conf -- /etc/proftpd/conf.d/sftp.conf
- proftpd.conf -- /etc/proftpd/proftpd.conf
