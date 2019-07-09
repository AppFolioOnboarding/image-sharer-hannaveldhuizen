import React from 'react';
import Header from './Header';
import FeedbackForm from './FeedbackForm';

export default function App() {
  return (
    <div>
      <Header title="Tell us what you think" />
      <div className="d-flex align-items-center flex-column">
        <FeedbackForm />
      </div>
    </div>
  );
}

/* TODO: Add Prop Types check*/
