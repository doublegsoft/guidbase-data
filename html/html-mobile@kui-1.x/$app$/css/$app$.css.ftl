:root {
  /* main colors */
  --color-primary: #73b17b; /*#1976d2;*/
  --color-secondary: #1976d2;;
  --color-success: #2e7d32;
  --color-error: #d32f2f;
  --color-warning: #ed6c02;
  --color-info: #0288d1;
  --color-white: #fff;

  --color-primary-light: #a3e3aa;
  --color-primary-dark: #44814e;

  --color-secondary-light: #63a4ff;
  --color-secondary-dark: #004ba0;

  /*--color-text-primary: rgba(0, 0, 0, 0.87);*/
  --color-text-primary: #5c6873;;
  --color-text-secondary: rgba(153, 153, 153, 1);
  --color-text-disabled: rgba(0, 0, 0, 0.38);

  --color-background: rgba(248,248,249,1);
  --color-background-card: rgb(255, 255, 255);
  --color-background-tag: #f8f8f8;
  --color-background-input: #fff;

  --color-background-toast: #ababab;

  --color-divider: rgba(0, 0, 0, 0.12);
  --color-mask: rgba(0, 0, 0, 0.3);

  --color-shadow-primary: rgba(115, 177, 123, 0.6);

  /*--color-primary-light: #42a5f5;*/
  /*--color-secondary-light: #ba68c8;*/
  --color-success-light: #4caf50;
  --color-error-light: #ef5350;
  --color-warning-light: #ff9800;
  --color-info-light: #03a9f4;

  /*--color-primary-dark: #1565c0;*/
  /*--color-secondary-dark: #7b1fa2;*/
  --color-success-dark: #1b5e20;
  --color-error-dark: #c62828;
  --color-warning-dark: #e65100;
  --color-info-dark: #01579b;

  --color-light: #ebedef;
  --color-text-primary-dark: #fff;
  --color-text-secondary-dark: rgba(255, 255, 255, 0.7);
  --color-text-disabled-dark: rgba(255, 255, 255, 0.5);
  --color-background-dark: #121212;
  --color-divider-dark: rgba(255, 255, 255, 0.12);
}

.form-control {
  background: unset !important;
}


.switch-item .c-switch {
  position: relative;
  width: 80px;
  height: 34px;
  margin-bottom: 0;
}

.switch-item .c-switch-slider::before {
  position: absolute;
  top: 0;
  left: 0;
  box-sizing: border-box;
  width: 40px;
  height: 34px;
  background-color: #e8e8e8;
  transition: .15s ease-out;
  content: attr(data-checked);
  border-radius: 4px;
  border: 0;
  line-height: 34px;
  text-align: center;
}

.switch-item .c-switch-info .c-switch-input:checked + .c-switch-slider {
  background-color: var(--color-primary);
  border-color: var(--color-primary);
}

.switch-item .c-switch-slider {
  position: relative;
  display: block;
  height: 34px;
  cursor: pointer;
  background-color: var(--color-primary);
  border: 0;
  transition: .15s ease-out;
  border-radius: 6px;
  color: #fff;
  font-size: 14px;
}

.switch-item .c-switch-label .c-switch-input:checked ~ .c-switch-slider::before {
  -webkit-transform: translateX(40px);
  transform: translateX(40px);
}

.c-switch-info .c-switch-input:checked + .c-switch-slider::before {
  border-color: #e8e8e8;
  content: attr(data-unchecked);
}

.c-switch-label .c-switch-slider::after {
  color: #fff;
  font-size: 14px;
  right: 0;
}