require_relative 'self'

describe Person do
  describe '#example_instance_method' do
    it 'should return a greeting from the instance' do
      p = Person.new
      expect(p.example_instance_method).to eq("Hello from an instance method!")
    end
  end

  describe '#what_is_self?' do
  end

  describe '::example_class_method' do
    it 'should return a greeting from the class' do
    end
  end

  describe '::what_is_self?' do
  end
end

describe Math do
end
