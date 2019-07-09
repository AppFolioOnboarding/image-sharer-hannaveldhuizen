/* eslint-env mocha */

import { expect } from 'chai';
import { shallow } from 'enzyme';
import React from 'react';
import Footer from '../../components/Footer';

describe('<Footer />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<Footer text="Text" />);
    const footer = wrapper.find('footer');
    expect(footer).to.have.length(1);
    expect(footer.text()).to.equal('Text');
  });
});
