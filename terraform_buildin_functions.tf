#### Terraform Builtin Funtions

##################
# Concat two lists
##################

variable "list1" {
    type = list
    default = ["a", "b"]
}

variable "list2" {
    type = list
    default = ["c", "d"]
}

output "combined_list" {
    value = concat(var.list1,var.list2)
}

#Outputs:
#+combined_list = tolist([
# + "a",
# + "b",
# + "c",
# + "d",
#])

########################################################################
# Element (Returns the element at the specified index in a list)
########################################################################

variable "my_list" {
    type = list
    default = ["apple", "banana", "cherry"]
}

output "selected_element" {
    value = element(var.my_list, 1)
}


#Outputs:   + selected_element = "banana"

#########################################################
# length(list): Returns the number of elements in a list.
#########################################################

output "list_length" {
    value = length(var.my_list)
}

#Outputs:   + list_length      = 3

##########################################################################
# map(key, value): Creates a map from a list of keys and a list of values.
##########################################################################

variable "keys" {
    type = list
    default = ["name", "age"]
}

variable "values" {
    type = list
    default = ["Vamshi", "33"]
}

output "mapping" {
    value = tomap({name=var.values, age=var.values})
    #value = map(var.keys, var.values) ---> Call to function "map" failed: the "map" function was deprecated in Terraform v0.12 and is no longer available; use tomap({ ... }) syntax to write a literal map
}
  
#Outputs:   + mapping          = {
#      + age  = [
#          + "Vamshi",
#          + "33",
#        ]
#      + name = [
#          + "Vamshi",
#          + "33",
#        ]
#    }

################################################################################
# lookup(map, key): Retrieves the value associated with a specific key in a map.
################################################################################

variable "my_map" {
    type = map(string)
    default = {"name" = "Vamshi", "age" = "33"}
}

output "lookup" {
    value = lookup(var.my_map, "name")
}

#Outputs:    + lookup           = "Vamshi"

########################################################################################################
#join(separator, list): Joins the elements of a list into a single string using the specified separator.
########################################################################################################

variable "my_joinlist" {
    type = list
    default = ["apple", "banana", "cherry"]
}

output "join" {
    value = join(", ", var.my_joinlist)
}

#Outputs:   + join             = "apple, banana, cherry"