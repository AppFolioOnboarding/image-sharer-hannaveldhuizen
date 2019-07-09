import PropTypes from 'prop-types';
import React from 'react';

export default function Footer(props) {
  return (
    <footer className="pt-4">
      <p>{props.text}</p>
    </footer>
  );
}

Footer.propTypes = {
  text: PropTypes.string.isRequired
};
