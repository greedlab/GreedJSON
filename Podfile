# the name of the project
workspace 'GreedJSON'

platform :ios, '6.0'

# the path of test project
xcodeproj 'Example/Example'

def target_pods
    # the path of .podspec
    pod 'GreedJSON', :path => './'
end

target 'Example' do
    target_pods
end

target 'ExampleUnitTests' do
    target_pods
end
