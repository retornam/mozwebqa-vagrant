# Vagrant Setup for MozWebQA Projects

To get you started with MozWebQA projects as soon and as easily as we can.

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

#### Requirements for Selenium based projects

- Make sure you have Firefox installed.
- Download Selenium Standalone Server JAR from [Selenium on Google Code][GC].

[GC]: http://code.google.com/p/selenium/downloads/list

#### Setting up Vagrant and the VM

```
# run selenium-server-standalone-<version>.jar

# clone mozwebqa-vagrant from Github
git clone git@github.com:retornam/mozwebqa-vagrant.git

# get into the cloned project's directory
cd mozwebqa-vagrant

# use vagrant to start the VM with our configuration
vagrant up

# ssh into the VM to use it
vagrant ssh -- -R 4444:localhost:4444
```

#### Running tests

To get you started, lets take `mcom-tests` as an example. Run the following 
commands in the `ssh session` you started using Vagrant in the previous section.

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
running Firefox. In this case, it is the OS you are using. So if you are using
Linux, set `--platform=linux` and if you are using Mac, the set 
`--platform=mac`.
