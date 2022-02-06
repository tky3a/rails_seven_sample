import React from 'react';
import ReactDOM from 'react-dom';

const DrawerButton = () => {
    return (
      <button type="button" class="drawer-toggle drawer-hamburger">
        <div class="drawer-menu w-5">
          <div class="bg-white h-0.5"></div>
          <div class="h-1"></div>
          <div class="bg-white h-0.5"></div>
          <div class="h-1"></div>
          <div class="bg-white h-0.5"></div>
        </div>
      </button>
    )
};

// id="drawer_button"　に表示する
ReactDOM.render(
    <DrawerButton />, document.getElementById('drawer_button')
  );