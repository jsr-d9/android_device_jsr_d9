#!/usr/bin/env python

import os, sys, time

# Put the modifications that you need to make into the /system/build.prop into this
# function. The prop object has get(name) and put(name,value) methods.
def mangle_build_prop_hook(prop, overrides):
  """call mangle_build_prop_hook"""
  prop.put("ro.com.android.dateformat", "yyyy-MM-dd")
  pass

# Put the modifications that you need to make into the /system/build.prop into this
# function. The prop object has get(name) and put(name,value) methods.
def mangle_default_prop_hook(prop):
  """call mangle_default_prop_hook"""
  pass
