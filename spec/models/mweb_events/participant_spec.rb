require 'spec_helper'

module MwebEvents
  describe Participant do

      it { should validate_presence_of(:event_id) }
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email).scoped_to(:event_id) }
      it { should validate_presence_of(:owner_id) }
      it { should validate_uniqueness_of(:owner_id).scoped_to(:event_id) }

      it { should belong_to(:event) }
      it { should belong_to(:owner) }

      it { should respond_to(:email) }
      it { should respond_to(:email=) }
      it { should respond_to(:event) }
      it { should respond_to(:event=) }
      it { should respond_to(:event_id) }
      it { should respond_to(:event_id=) }

  end
end
