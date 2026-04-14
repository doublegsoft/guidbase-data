@import "/vendor/gux/gux.wxss";

page {
  background: var(--color-background);
}

view.content {
  margin: auto; 
  align-items: center; 
  justify-items: center;
  text-align: center;
}

view.theme-image {
  font-size: 156px; 
  color: var(--color-success);
}

button.primary {
  width: 80%; 
  height: 48px; 
  background-color: var(--color-success);
  color: white; 
  line-height: 32px; 
  font-size: 20px;
}

button.secondary {
  width: 80%; 
  height: 48px; 
  background-color: var(--color-success-lighter);
  color: var(--color-success); 
  line-height: 32px; 
  font-size: 20px;
}

text.title {
  font-size: 22px;
  text-align: center;
  display: block;
}

text.description {
  padding-top: 8px;
  font-size: 18px;
  color: var(--color-text-secondary);
}