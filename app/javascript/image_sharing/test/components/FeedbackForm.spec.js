/* eslint-env mocha */

import { expect } from 'chai';
import { shallow } from 'enzyme';
import React from 'react';
import FeedbackForm from '../../components/FeedbackForm';

describe('<FeedbackForm />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<FeedbackForm />);
    expect(wrapper.find('Label')).to.have.length(2);
    expect(wrapper.find('Input')).to.have.length(2);
    expect(wrapper.find('Button')).to.have.length(1);
  });
});
