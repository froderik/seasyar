seasyar
=======

Seasyar is an active record implementation for seasy. It has two parts: an active record implementation of the storage interface of seasy and a way to make it easy to use with an active record model regardless of what storage you use.


Use seasyar in your rails model classes
---------------------------------------

Say you have a person class with the fields first_name, last_name and phone_number. To add search to this put the following somewhere in your class:

    include Seasyar
     
    after_save do
      index index_name, :first_name, :last_name, :phone_number
    end
     
    before_destroy do
      unindex index_name
    end

and seasyar will use the configured seasy storage to update the named index. If none of the fields have changed the index will not be updated. 

Also included with the module is a reindex method that can be used to force reindexing for an object. Just use it in the same way as index.

    reindex index_name, :first_name, :last_name, :phone_number

This can be useful when adding seasyar for the first time to put index on all existing objects. Something like:

    Person.all.each { |p| p.reindex index_name, :first_name, :last_name, :phone_number }

on the command line will do it.


Searching
---------

Seasyar also adds a convenience method for searching:

    include Seasyar
    
    search index_name, query
    
but it is of course possible to use seasy directly also.


Storing the index with active record
------------------------------------

You need to configure seasy to use the active record storage in seasyar. Put this in an initiliazer of before your code. 

    Seasy.configure do |config|
      config.storage = ActiveRecordStorage
    end

You can use another storage implementation and still use sesyar for easy integration with seasy in your model classes.

You also need to put the following migration somewhere in your code (might build a generator for this....):

    create_table "seasy_data", :force => true do |t|
      t.string   "key"
      t.string   "target"
      t.integer  "weight"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "source"
      t.string   "index_name"
    end
    

Copyright
---------

Copyright (c) 2011 Fredrik Rubensson. See LICENSE.txt for
further details.

