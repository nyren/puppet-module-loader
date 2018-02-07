puppet-module-loader
====================

A Puppet module to load other Puppet modules, i.e. include classes into the
manifest.

The purpose of puppet-module-loader is to allow both adding to and *removing
from* the list of classes defined in Hiera.

# Background
------------
The common pattern for loading modules (classes) through Hiera is to use the
array-type parameter "classes". The classes specified in this array is
typically loaded into the manifest by <tt>hiera\_include("classes")</tt> in
<tt>site.pp</tt>.

While it is possible to *add* items to the <tt>classes</tt> array in different
levels of Hiera, it is not possible to *remove* a class name already in the list.

This drives a Hiera pattern where e.g. <tt>common.yaml</tt> can only contain the
minimal set of common modules to load. There is no way to define any **exceptions**.

# Compatibility
---------------
The loader module is built for use with both Puppet 3.x, 4.x and 5.x. The
module is platform independent.

# Examples
----------

Include basic set of modules in Hiera common.yaml:

    loader::classes:
      hosts:   true
      ntp:     true
      pam:     true
      rsyslog: true
      ssh:     true

Include additional modules in a group, e.g. groups/webserver.yaml:

    loader::classes:
      apache:     true
      postgresql: true

Exclude modules from a particular host, e.g. fqdn/host1.example.com.yaml:

    loader::classes:
      hosts: false
      ssh:   false

# Parameters
------------

ensure
------
The string <tt>'present'</tt> or <tt>'absent'</tt>. If 'present' the loader
module will be active, otherwise it will have no effect.

- *Default*: 'present'

classes
-------
A hash specifying the modules to include. The key is the module name and the
value is a boolean. If the value is <tt>true</tt> the module will be included,
if the value is <tt>false</tt> it will not be included.

- *Default*: {}

hiera\_merge
------------
A boolean controlling whether the <tt>classes</tt> parameter should be merged
together from all instances of <tt>loader::classes</tt> in Hiera.

- *Default*: true
