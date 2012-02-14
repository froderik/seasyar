seasyar
=======

Seasyar is an active record implementation for seasy. It has two parts: an active record implementation of the storage interface of seasy and a way to make it easy to use with an active record model regardless of what storage you use.


Configuration
-------------

To configure seasyar put this in an initiliazer of before your code. 

    Seasy.configure do |config|
      config.storage = ActiveRecordStorage
    end

Once configured you can either use seasy directly as described in the seasy documentation. Or you can:


Use seasyar in your rails model classes
---------------------------------------

Say you have a person class with the fields first_name, last_name and phone_number. To add search to this put the following somewhere in you class

     include Seasyar
     
     after_save do
       index index_name, :first_name, :last_name, :phone_number
     end
     
     before_destroy do
       unindex index_name
     end

and seasyar will use the configured seasy storage to update the named index. 



Copyright
---------

Copyright (c) 2011 Fredrik Rubensson. See LICENSE.txt for
further details.

