// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ImagesController from "./images_controller"
application.register("images", ImagesController)

import SelectmenuController from "./selectmenu_controller"
application.register("selectmenu", SelectmenuController)

import TagController from "./tag_controller"
application.register("tag", TagController)
