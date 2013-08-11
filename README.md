# Activeadmin-cms

This gem provides you with a number of rudimentary features you can use to create simple page types for simple websites:

* Based on the excellent activeadmin dashboard;
* A page editor
* A page preview
* A page template editor
* A simple media storage (using paperclip)
* The page object allows you to query for pages with certain properties

Follow the instructions below to get it working.

## Gemfile setup

Make sure you have these gems declared in your `Gemfile`.

	gem 'activeadmin', '0.5.1'
	gem 'paperclip', '3.4.0'
	gem 'jquery-rails', '2.2.1'
	gem 'tinymce-rails'
	gem 'activeadmin-cms', :git => "http://github.com/marnixk/activeadmin-cms"

Then run `bundle install` to get all the gems.

## Copy migrations:

	$ bundle exec rake railties:install:migrations
	$ rails generate active_admin:install --skip-users
	$ rake db:migrate

Remember, the default user is: 'admin@example.com / password'


## Route configuration

In `config/routes.rb` make sure you have the following configuration setup. The first line is to get the admin_users working, the
second line is to mount the activeadmin stuff the cmsgem loads out of the box.
	
	devise_for :admin_users, ActiveAdmin::Devise.config
	mount Cmsgem::Engine => "/"


## Getting the assets ready

Create a new file or add the following to `assets/javascripts/active_admin_custom.js`.

	//= require active_admin/base
	//= require tinymce-jquery

	$(document).ready(function() {
		$(".tinymce").tinymce({
			theme: 'advanced',
			relative_urls : false,
			content_css : "/assets/tinymce_content.css"
		});
		
	});

Add create or add these to the active_admin stylesheet at `assets/stylesheets/active_admin.css.scss`:

	.has_many.property_settings .button {
		display: none !important;
	}

	textarea.tinymce {
		height: 600px;
	}

	.image-sample {
		max-height: 320px;
		max-width: 480px;
	}

	.file-selection {
		width: 250px;
	}

	.admin_cms a {
		text-decoration: none;
	}

	.admin_cms tr.odd {
		background-color: #f0f0f0;
	}

	.admin_cms tr:hover .options {
		visibility: visible;
	}

	.admin_cms .options {
		padding-left: 5px;
		font-size: 10px;
		visibility: hidden;
	}

	.admin_cms .level-1 td {
		font-size: 1.1em;
		font-weight: bold;
		border-top: 1px solid #666F74;
	}

	.admin_cms .options a {
		color: #666;
	}

	.admin_cms .options a:hover {
		color: #333;
		text-decoration: underline;
	}

	.admin_pages form textarea {
		font-size: 13px;
	}

	.admin_pages .datepicker input {
		width: 200px;
	}

	.admin_pages #page-preview {
		width: 100%;
		height: 600px;
	}

	.defaultSkin table.mceToolbar, .defaultSkin tr.mceFirst .mceToolbar tr td, .defaultSkin tr.mceLast .mceToolbar tr td {
		width: auto;
	}

	.defaultSkin .mceListBox .mceText {
		text-decoration: none;
		color: black;
	}

	.defaultSkin .mceListBoxMenu {
		background-color: white;

		a, .mceText {
			text-decoration: none;
		}
	}

## Future work

There are a number of things that bother me:

* get rid of Cmsgem namespace and rename it to something more sane
* have a better out of the box solution for the stylesheet that needs to be overridden every time
* replace the page editor with a simple AngularJS application that offers a richer interface.
* BUG: page properties don't show when you haven't set the template type yet, make the page store and reload on page type change.

