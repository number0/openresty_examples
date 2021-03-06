local sqlite3 = require("./utils/ulua/lsqlite3complete/0_9_4+203/Linux/x64/-lsqlite3complete")
local rows = {}
db_mem = sqlite3.open_memory()

local optbl = {
   [sqlite3.UPDATE] = "UPDATE";
   [sqlite3.INSERT] = "INSERT";
   [sqlite3.DELETE] = "DELETE"
}
setmetatable(optbl,
	     {__index=function(t,n) return string.format("Unknown op %d",n) end})

-- we can use nginx shared dictionary to pass the data
--from the location blocks to the update_hook

local udtbl = {0, 0, 0}


db_mem:update_hook( function(ud, op, dname, tname, rowid)
      local print_val = string.format("%s %s %s %s", optbl[op], dname, tname, rowid)
      ngx.say("Sqlite Update Hook:", print_val)
		    end, udtbl)

db_mem:exec[[
  CREATE TABLE test ( id INTEGER PRIMARY KEY, content VARCHAR );

  INSERT INTO test VALUES (NULL, 'Hello World');
  INSERT INTO test VALUES (NULL, 'Hello Lua');
  INSERT INTO test VALUES (NULL, 'Hello Sqlite3');
  UPDATE test SET content = 'Hello Again World' WHERE id = 1;
  DELETE FROM test WHERE id = 2;
]]

for row in db_mem:nrows("SELECT * FROM test") do
   table.insert(rows,row)   
end
ngx.say(cjson.encode({rows=rows}))
