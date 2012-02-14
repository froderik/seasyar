seasyar
=======

Seasyar is an active record implementation for seasy. It has two parts: an active record implementation of the storage interface of seasy and a way to make it easy to use with an active record model regardless of what storage you use.



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

