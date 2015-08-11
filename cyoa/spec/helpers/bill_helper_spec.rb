require 'rails_helper'

describe BillHelper, type: :helper do
  describe '#bill_title' do
    context 'returns popular title' do
      before { @bill = build(:bill, popular_title: 'Popular') }

      it 'uses the popular title when it exists' do
        expect(helper.bill_title).to include(@bill.popular_title)
      end
    end

    context 'returns short title' do
      before { @bill = build(:bill, popular_title: nil, short_title: 'Short') }

      it 'uses the short title when the popular title doesn\'\t exist' do
        expect(helper.bill_title).to include(@bill.short_title)
      end
    end

    context 'returns official title' do
      before { @bill = build(:bill, popular_title: nil, short_title: nil, official_title: 'Official') }

      it 'uses the offiial title when neither popular nor short exist' do
        expect(helper.bill_title).to include(@bill.official_title)
      end
    end
  end

  describe '#bill_current_status' do
    context 'enacted bill' do
      before do
        @bill = create(:bill)
        create(:bill_action, bill_id: @bill.id, text: 'Became Public Law - No.1')
      end

      it 'returns the full enacted text' do
        expect(helper.bill_current_status).to eq('Became Public Law - No.1')
      end
    end

    context 'signed bill' do
      before do
        @bill = create(:bill)
        create(:bill_action, bill_id: @bill.id, text: 'Signed by President.')
      end

      it 'returns the signed text' do
        expect(helper.bill_current_status).to eq('Signed by President.')
      end
    end

    context 'vetoed bill' do
      before do
        @bill = create(:bill)
        create(:bill_action, bill_id: @bill.id, text: 'Vetoed by President.')
      end

      it 'returns the vetoed text' do
        expect(helper.bill_current_status).to eq('Vetoed by President.')
      end
    end

    context 'introduced only' do
      before do
        @bill = build(:bill, chamber: 'senate')
      end

      it 'returns the introductory text' do
        expect(helper.bill_current_status).to eq('Introduced to Senate')
      end
    end

    context 'simple resolutions' do
      context 'sres passes senate' do
        before do
          @bill = create(:bill, bill_type: 'sres')
          create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'senate', date: Date.parse('2015-01-01'))
        end

        it 'is Agreed To in the Senate' do
          expect(helper.bill_current_status).to eq('Agreed To Simple Resolution')
        end
      end

      context 'hres passes senate' do
        before do
          @bill = create(:bill, bill_type: 'hres')
          create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'house', date: Date.parse('2015-01-01'))
        end

        it 'is Agreed To in the House' do
          expect(helper.bill_current_status).to eq('Agreed To Simple Resolution')
        end
      end

      context 'error cases' do
        context 'sres passes house' do
          before do
            @bill = create(:bill, bill_type: 'sres')
            create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'house', date: Date.parse('2015-01-01'))
          end

          it 'is nil' do
            expect(helper.bill_current_status).to eq(nil)
          end
        end

        context 'hres passes senate' do
          before do
            @bill = create(:bill, bill_type: 'hres')
            create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'senate', date: Date.parse('2015-01-01'))
          end

          it 'is nil' do
            expect(helper.bill_current_status).to eq(nil)
          end
        end
      end
    end

    context 'concurrent resolutions' do
      context 'sconres passes Senate' do
        before do
          @bill = create(:bill, bill_type: 'sconres')
          create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'senate', date: Date.parse('2015-01-01'))
        end

        it 'passes in the senate' do
          expect(helper.bill_current_status).to eq('Passed Senate on Jan 1, 2015')
        end
      end

      context 'sconres passes both houses' do
        before do
          @bill = create(:bill, bill_type: 'sconres')
          create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'senate')
          create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'house')
        end

        it 'is Agreed To by both houses' do
          expect(helper.bill_current_status).to eq('Agreed To Concurrent Resolution')
        end
      end

      context 'hconres passes House' do
        before do
          @bill = create(:bill, bill_type: 'hconres')
          create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'house', date: Date.parse('2015-01-01'))
        end

        it 'passes in the House' do
          expect(helper.bill_current_status).to eq('Passed House on Jan 1, 2015')
        end
      end

      context 'hconres passes both houses' do
        before do
          @bill = create(:bill, bill_type: 'hconres')
          create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'senate')
          create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'house')
        end

        it 'is Agreed To by both houses' do
          expect(helper.bill_current_status).to eq('Agreed To Concurrent Resolution')
        end
      end
    end

    context 'senate bill' do
      context 'passes Senate' do
        before do
          @bill = create(:bill, bill_type: 's')
          create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'senate', date: Date.parse('2015-01-01'))
        end

        it 'passes in the Senate' do
          expect(helper.bill_current_status).to eq('Passed Senate on Jan 1, 2015')
        end
      end

      context 'passes Senate and House' do
        before do
          @bill = create(:bill, bill_type: 's')
          create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'senate', date: Date.parse('2015-01-01'))
          create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'house', date: Date.parse('2015-01-01'))
        end

        it 'passes in the House' do
          expect(helper.bill_current_status).to eq('Passed House on Jan 1, 2015')
        end
      end
    end

    context 'house bill' do
      context 'passes House' do
        before do
          @bill = create(:bill, bill_type: 'hr')
          create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'house', date: Date.parse('2015-01-01'))
        end

        it 'passes in the House' do
          expect(helper.bill_current_status).to eq('Passed House on Jan 1, 2015')
        end
      end

      context 'passes House and Senate' do
        before do
          @bill = create(:bill, bill_type: 'hr')
          create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'senate', date: Date.parse('2015-01-01'))
          create(:bill_action, bill_id: @bill.id, result: 'pass', chamber: 'house', date: Date.parse('2015-01-01'))
        end

        it 'passes in the House' do
          expect(helper.bill_current_status).to eq('Passed Senate on Jan 1, 2015')
        end
      end
    end
  end

  describe '#bookmark_options' do
    context 'when the user bookmarked the bill' do
      before do
        @bill = create(:bill)
        user_id = 1
        user = double('current_user', id: user_id)
        allow(helper).to(receive(:current_user).and_return(user))
        create(:user_bill, user_id: user_id, bill_id: @bill.id)
      end

      it 'is already bookmarked' do
        expect(helper.bookmark_options).to include('Bookmarked!')
      end
    end

    context 'still able to bookmark' do
      before do
        @bill = create(:bill)
        user_id = 1
        user = double('current_user', id: user_id)
        allow(helper).to(receive(:current_user).and_return(user))
      end

      it 'shows a button to add to bookmarks' do
        expect(helper.bookmark_options).to include('Add to bookmarks')
      end
    end

    context 'when no current user' do
      before do
        @bill = build(:bill)
        allow(helper).to(receive(:current_user).and_return(nil))
      end

      it 'returns nil' do
        expect(helper.bookmark_options).to eq(nil)
      end
    end
  end
end
