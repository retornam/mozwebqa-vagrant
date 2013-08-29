# Vagrant Setup for MozWebQA Projects

This project is to help get your environment setup for contributing to our
WebQA projects as quickly and as easily as possible.

### Base Requirements

- [Vagrant][Vag] - you will need to Vagrant installed in your machine. Get 
  the latest version of Vagrant for your OS [here][VagDL].
- [VirtualBox][VB] - you will also need VirtualBox (or any other virtual 
  machine provider). Get VirtualBox [here][VBDL].

[Vag]: http://www.vagrantup.com/
[VagDL]: http://downloads.vagrantup.com/
[VB]: https://www.virtualbox.org/
[VBDL]: https://www.virtualbox.org/wiki/Downloads

## Usage Guide

### Getting started with Selenium based projects

Most of our WebQA projects use Selenium Webdriver. If you are interested in
contributing to our Selenium based projects, you may want to check out the
following projects:

- [marketplace-tests](https://github.com/mozilla/marketplace-tests)
- [mcom-tests](https://github.com/mozilla/mcom-tests)
- [sumo-tests](https://github.com/mozilla/sumo-tests)
- [addons-tests](https://github.com/mozilla/Addon-Tests)
- [qmo-tests](https://github.com/mozilla/qmo-tests)
- [remo-tests](https://github.com/mozilla/remo-tests)
- [socorro-tests](https://github.com/mozilla/Socorro-Tests)
- [mozillians-tests](https://github.com/mozilla/mozillians-tests)
- [mdn-tests](https://github.com/mozilla/mdn-tests)
- [moztrap-tests](https://github.com/mozilla/moztrap-tests)

#### Requirements for Selenium based projects

- Make sure you have Firefox installed.
- Make sure you have [Java Runtime][JRE] installed.
- Download Selenium Standalone Server JAR from [Selenium on Google Code][GC].

[JRE]: http://java.com/en/download/index.jsp
[GC]: http://code.google.com/p/selenium/downloads/list

#### Setting up Vagrant and the VM

1.  **Get mozwebqa-vagrant**

    1.  If you don't have Git, then download the latest archive from [here][archive].
        Unzip the downloaded file and change directory to `mozwebqa-vagrant-master`.

        ```
        cd mozwebqa-vagrant-master
        ```

    2.  If you have Git installed, then clone the repo:

        ```
	    # clone mozwebqa-vagrant from Github
	    git clone git@github.com:retornam/mozwebqa-vagrant.git

	    # get into the cloned project's directory
	    cd mozwebqa-vagrant
	    ```

2.  **Start Selenium Server**

    On Linux and Mac (you can just double-click as well on Mac to run the JAR):

    ```
    java -jar selenium-server-standalone-<version>.jar
    ```

    On Windows:

    ```
    # Actually I don't know, can someone fill in the right way of doing it?
    ```

3.  **Launch VM using Vagrant**

    ***Warning***: the next command will download files of about 280 MB in size.
    But it will do that only once and all your future usage of this command
    will use the files downloaded at your first run. Make sure that you are
    on the right network that you would like to use for quick download.

    ```
    # use vagrant to start the VM with our configuration
    vagrant up

    # ssh into the VM to use it
    vagrant ssh -- -R 4444:localhost:4444
    ```

[archive]: https://github.com/retornam/mozwebqa-vagrant/archive/master.zip

#### Running tests

To get you started, lets take [mcom-tests][mt] as an example. Run the following
commands in the `ssh session` you started using Vagrant in the previous section.

[mt]: https://github.com/mozilla/mcom-tests

```
# change directory to mozilla-projects
cd ~/mozilla-projects

# clone mcom-tests
git clone https://github.com/mozilla/mcom-tests.git

# change directory to mcom-tests
cd mcom-tests

# create a new virtual environment for this project
mkvirtualenv mcom-tests

# install python requirements
pip install -r requirements.txt

# run one test
py.test --baseurl=http://mozilla.org --host=localhost --port=4444 \
	--browsername=firefox --platform=mac \
	tests/test_about.py	-k test_footer_link_destinations_are_correct
```

In the `py.test` command, `--platform` should be the platform on which you are
running Selenium Server. In this case, it is the OS you are using. So if you
are using Linux, set `--platform=linux` and if you are using Mac, then set 
`--platform=mac`.

#### Synced Directories

One of the amazing things about Vagrant is that it allows you to run stuff on a
VM but you don't have to code on the VM so that you can use the tools of your
choice that you already have installed on your machine. Vagrant does this by
syncing a directory between the VM and your local file system. This is very
useful! Read more about [synced directories here][synced].

[synced]: http://docs.vagrantup.com/v2/synced-folders/index.html

If you are using this project, the clone of this repository gets you a
directory called `mozilla-projects` which comes with just a README.md file.
This directory gets synced with the VM and is available in the `HOME DIRECTORY`
in your VM by the same name. Whatever you do in this directory
`mozilla-projects` gets reflected in the directory `mozilla-projects` in your
clone of the repository on your local file system, and vice-versa.

So if you followed all the steps above in the section on `Running tests`, you
should now have a clone of `mcom-tests` repository in `mozilla-projects` on
your VM and inside the clone of `mozwebqa-vagrant` on your local file system.

### Other Important & Useful Vagrant Commands

Refer to all the Vagrant commands [here][vcommands].

[vcommands]: http://docs.vagrantup.com/v2/cli/index.html

#### Shutdown VM

To shutdown your running VM, use the following command:

```
vagrant halt
```

To forcefully shutdown the VM, use the above command with `--force` argument.

**Note:** After shutting down the VM, use `vagrant up` to bring the VM back up.

#### Status of VM

To know if your VM is currently running or not, you can use the following
command:

```
vagrant status
```

#### Destroy VM

To destroy your VM, use the following command:

```
vagrant destroy <vm-name>
```

`<vm-name>` is the name of the VM. You may get the name using the `vagrant 
status` command.

After destroying the VM, if you run `vagrant up` command again, Vagrant will
use the same files that it downloaded when you ran the `vagrant up` command
for the first time.

#### Suspend VM

Suspending the VM means that the VM's current state will be captured and saved
and the VM will be suspended. Now when you want to use the VM, you can resume
from the state when you suspended the VM.

To suspend the VM, use the following command:

```
vagrant suspend <vm-name>
```

`<vm-name>` is the name of the VM. You may get the name using the `vagrant 
status` command.

**Note:** don't use the `vagrant up` command to bring back a suspended VM. Use
the `vagrant resume` command instead. See next section for more details.

#### Resume a suspended VM

A suspended VM should be resumed. **Don't** use the `vagrant up` command to
bring back up a suspended VM. Use the following command instead:

```
vagrant resume <vm-name>
```

#### Reload VM

Sometimes when things go wrong and you just want to restart your VM, you may
use this command:

```
vagrant reload <vm-name>
```

### What to do when your VM gets stuck or unresponsive

We have heard from users who have experienced their VM gets stuck or
unresponsive while using `vagrant up` command or `vagrant ssh`. In such
situations, here are a few things you can try:

#### Reload the VM

Use the following command to shutdown and restart the VM:

```
vagrant reload <vm-name>
```

`<vm-name>` is the name of the VM. You may get the name using the `vagrant 
status` command.

#### Debug using VirtualBox GUI

You may want to start VirtualBox GUI and manually restart the VM and observe
what is going on and proceed accordingly.

#### Destroy the VM and start over

Destroy your existing VM using the following command:

```
vagrant destroy <vm-name>
```

And create a new VM again using `vagrant up` command. This has never failed
us :)
