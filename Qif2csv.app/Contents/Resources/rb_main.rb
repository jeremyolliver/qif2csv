$:.map! { |x| x.sub(/^\/Library\/Frameworks/, NSBundle.mainBundle.privateFrameworksPath) }
$:.unshift NSBundle.mainBundle.resourcePath.fileSystemRepresentation
load 'lib/application.rb'
