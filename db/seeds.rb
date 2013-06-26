# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

{ :magician       => [1,1,15,30],
  :swordsinger    => [2,2,7,50],
  :thief          => [4,4,5,70],
  :paladin        => [4,7,2,100],
  :warrior        => [10,5,2,100]
}.each_pair do |class_name,attributes_array|
  attributes_hash =   [:attack,:defence,:magic,:max_health].each.with_index.inject({}) do |hash, (attribute_name, index)|
                        hash[attribute_name] = attributes_array[index]
                        hash
                      end
  class_created   =   CharacterType.create! attributes_hash.merge({:name => class_name})
  Character.create!(:character_type_id => class_created)
end
