
class Media < ActiveRecord::Base

	#
	#  Should always have a binary
	#
	validates_attachment_presence :binary

	# 
	#  Savable fields
	# 
	attr_accessible :title, :binary, :page_id, :description, :identifier

	#
	#  Binary goes here
	#
	has_attached_file :binary

	#
	#  Can be associated to a page
	#
	belongs_to :page

	#
	#  Are we talking about an image?
	#
	def image?
		image_types = %w(image/png image/jpeg image/jpg image/gif)
		image_types.include? binary_content_type
	end


end

