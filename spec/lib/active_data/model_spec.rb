# encoding: UTF-8
require 'spec_helper'

describe ActiveData::Model do
  let(:model) do
    Class.new do
      include ActiveData::Model

      attribute :name
      attribute :count, default: 0
    end
  end

  specify { expect { model.blablabla }.to raise_error NoMethodError }
  specify { model.i18n_scope.should == :active_data }
  specify { model.new.should_not be_persisted }
  specify { model.instantiate({}).should be_an_instance_of model }
  specify { model.instantiate({}).should be_persisted }

  context 'Fault tolerance' do
    specify{ expect { model.new(foo: 'bar') }.not_to raise_error }
  end

  describe '#instantiate' do
    context do
      subject(:instance) { model.instantiate(name: 'Hello', foo: 'Bar') }

      specify { subject.instance_variable_get(:@attributes).should == { name: 'Hello', count: nil } }
    end
  end
end
