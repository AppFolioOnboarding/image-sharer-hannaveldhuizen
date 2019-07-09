/* eslint-env mocha */

import { expect } from 'chai';
import { shallow } from 'enzyme';
import React from 'react';
import App from '../../components/App';
import FeedbackForm from '../../components/FeedbackForm';
import Footer from '../../components/Footer';

describe('<App />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<App />);
    expect(wrapper.find(FeedbackForm)).to.have.length(1);
    expect(wrapper.contains('Tell us what you think'));
    expect(wrapper.find(Footer)).to.have.length(1);
  });
});
