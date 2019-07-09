import React from 'react';
import Header from './Header';
import FeedbackForm from './FeedbackForm';
import Footer from './Footer';

export default function App() {
  return (
    <div>
      <Header title="Tell us what you think" />
      <div className="d-flex align-items-center flex-column">
        <FeedbackForm />
        <Footer text="Copyright: Appfolio Inc. Onboarding" />
      </div>
    </div>
  );
}

/* TODO: Add Prop Types check*/
