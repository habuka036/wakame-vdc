
def public_crud obj
  public_name = obj.table_name.to_s # instances
  model = obj.to_s # Instances

list_instance = eval(<<END )
  proc do
    protected!
    #{public_name}_render(#{model}.all)
  end
END
  
get_instance = eval(<<END )
  proc do |id|
    protected!
    obj = #{model}.find(:id=>id.to_i)
    #{public_name}_render(obj)
  end
END

new_instance = eval(<<END )
  proc do
    protected!
    req_hash = JSON.parse(request.body.read)
    obj = #{model}.new
    obj.set_all(req_hash)
    obj.save
    #{public_name}_render(obj)
  end
END

update_instance = eval(<<END )
  proc do |id|
    protected!
    obj = #{model}.find(:id=>id.to_i)
    req_hash = JSON.parse(request.body.read)
    req_hash.delete 'id'
    obj.set_all(req_hash)
    obj.save
    #{public_name}_render(obj)
  end
END

destroy_instance = eval(<<END )
  proc do |id|
    protected!
    obj = #{model}.find(:id=>id.to_i)
    obj.destroy
    #{public_name}_render(obj)
  end
END
  
eval(<<END )
  def #{public_name}_render(obj)
    def obj2hash i
        Hash[i.keys.collect{ |key| [key, i[key]] }]
    end
    
    if obj.is_a?(Array)
      JSON.generate(obj.collect{|i| obj2hash(i)})
    else
      JSON.generate(obj2hash(obj))
    end
  end
END

  get    "/#{public_name}.json"  ,&list_instance
  
  post   "/#{public_name}.json"  ,&new_instance
  
  get    %r{/#{public_name}/(\d+).json}  ,&get_instance
  put    %r{/#{public_name}/(\d+).json}  ,&update_instance
  delete %r{/#{public_name}/(\d+).json}  ,&destroy_instance
end
