class ChangeMagickToMagicForCharacter < ActiveRecord::Migration
  def up
    rename_column :characters, :magick, :magic
  end

  def down
    rename_column :characters, :magic, :magick
  end
end
