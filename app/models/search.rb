class Search < ActiveRecord::Base
  require 'ostruct'
  
  def self.union(search=[],user_id)
    if search && search.length > 0
      Search.create(term: search,user_id: user_id)
      search = search.split(' ')
      sqlite = 'SELECT users.id, users.first_name,users.last_name,users.middle_name,stars.number
                 FROM users 
                 LEFT OUTER JOIN stars on stars.master_id = users.id 
                 WHERE users.lawyer = true AND ('
      search.map do |sql|
        sqlite += "users.first_name LIKE '%"+sql+"%' or users.last_name LIKE '%"+sql+"%' or users.middle_name LIKE '%"+sql+"%' AND " 
      end
      sqlite = sqlite.chomp(" AND ")
      sqlite += ")"
      #Disable searching for patents for now until a sutable relpacement can be found, edit: probably firms
      #sqlite += "UNION SELECT distinct n.name,n.category,n.tags,n.id,stars.number, 'patents' AS type FROM patents as n LEFT OUTER JOIN stars on stars.master_id = n.id WHERE "
      #search.map do |sql|
       #sqlite += "n.category LIKE '%"+sql+"%' or n.name LIKE '%"+sql+"%' AND "
      #end
      #sqlite = sqlite.chomp(" AND ")
      #sqlite += " GROUP BY n.id"
      results = ActiveRecord::Base.connection.execute(sqlite)
      if results.present?
        search_result = []
        results.each do |result|
          if result[5] == "firm"
            x = {:id => result["id"], :name => result['name'], :category => result['category'], :tags => result['tags'], :number => result['number'], :type => 'firm'}
            search_result.push OpenStruct.new x
          else
            x = {:id => result[0], :first_name => result[1], :last_name => result[2], :middle_name => result[3], :number => result[4].to_i, :type => 'user'}
            search_result.push OpenStruct.new x
          end
        end
        return search_result
      else
      return []
      end
    else
    return []
    end
  end
end
