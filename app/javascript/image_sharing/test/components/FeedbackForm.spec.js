/* eslint-env mocha */

import { expect } from 'chai';
import { shallow } from 'enzyme';
import React from 'react';
import sinon from 'sinon';
import FeedbackForm from '../../components/FeedbackForm';
import * as helper from '../../utils/helper';

describe('<FeedbackForm />', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = shallow(<FeedbackForm />);
  });

  it('should render correctly', () => {
    expect(wrapper.find('Label')).to.have.length(2);
    expect(wrapper.find('Input')).to.have.length(2);
    expect(wrapper.find('Button')).to.have.length(1);
  });

  it('should call onNameChange once when the input value is updated', () => {
    const spy = sinon.spy(wrapper.instance(), 'onNameChange');

    wrapper.find('#name').simulate('change', { target: { value: 'Hanna' } });

    expect(spy.calledOnce);
    expect(wrapper.find('#name').prop('value')).to.equal('Hanna');
  });

  it('should call onCommentsChange once when the input value is updated', () => {
    const spy = sinon.spy(wrapper.instance(), 'onCommentsChange');

    wrapper.find('#comment').simulate('change', { target: { value: 'Comments' } });

    expect(spy.calledOnce);
    expect(wrapper.find('#comment').prop('value')).to.equal('Comments');
  });

  it('should call onSubmit when button is clicked', () => {
    const stub = sinon.stub(wrapper.instance(), 'onSubmit');

    wrapper.find('Button').simulate('click');

    expect(stub.calledOnce);
  });

  describe('onSubmit', () => {
    it('should send a post request and get ok response', () => {
      const stub = sinon.stub(helper, 'post').resolves({ message: 'success' });

      return wrapper.instance().onSubmit()
        .then(() => {
          expect(stub.calledOnce);
          expect(wrapper.state('alertMessage')).to.equal('success');
        }).finally(() => {
          sinon.restore();
        });
    });

    it('should send a post request and get error response', () => {
      const stub = sinon.stub(helper, 'post').rejects({ data: { message: 'error' } });

      return wrapper.instance().onSubmit()
        .then(() => {
          expect(stub.calledOnce);
          expect(wrapper.state('alertMessage')).to.equal('error');
        }).finally(() => {
          sinon.restore();
        });
    });
  });

  describe('alert', () => {
    it('should return success alert on successful post', () => {
      wrapper.setState({ alertMessage: 'success' });
      expect(wrapper.find('Alert').prop('children')).to.equal('Feedback submitted successfully!');
    });

    it('should return success alert on successful post', () => {
      wrapper.setState({ alertMessage: 'error' });
      expect(wrapper.find('Alert').prop('children')).to.equal('An error occurred.');
    });
  });
});
