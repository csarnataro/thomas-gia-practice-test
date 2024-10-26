export class Countdown extends HTMLElement {
  static observedAttributes = ["stop-on-zero", "seconds"];

  seconds = 15;
  initialSeconds = 15;
  stopOnZero = true;

  initialTemplate() {
    return `
        <label> 
            <span class="elapsed">${this.initialSeconds}</span> / <span class="initial">${this.initialSeconds}</span>:
            <progress class="" max="100" value="0">${this.initialSeconds}
            </progress>
        </label>
        <style>
            .elapsed {
                display: inline-block;
                min-width: 50px;
                text-align: right;
            }

            progress.expired[value]::-webkit-progress-value,
            progress.expired[value] {
                --color: #ff385f;
            }

            progress[value] {
                --color: #20d160;
                --background: #dbdbdb;
                -webkit-appearance: none;
                -moz-appearance: none;
                appearance: none;
                border: none;
                width: 200px;
                margin: 0 10px;
                border-radius: 10em;
                background: var(--background);
            }
            progress[value]::-webkit-progress-bar {
                border-radius: 10em;
                background: var(--background);
            }                
            progress[value]::-webkit-progress-value {
                border-radius: 10em;
                background: var(--color);
            }
            progress[value]::-moz-progress-bar {
                border-radius: 10em;
                background: var(--color);
            }
        </style>
    `;
  }

  constructor() {
    super();
  }

  formatSeconds(seconds) {
    switch (true) {
      case seconds >= 10 || seconds <= -10:
        return this.seconds;
      case seconds >= 0:
        return `0${this.seconds}`;
      case seconds > -10:
        return `-0${-1 * this.seconds}`;
      default:
        return this.seconds;
    }
  }

  connectedCallback() {
    const shadow = this.attachShadow({ mode: "open" });
    this._setInitialAttributes();
    const content = document.createElement("span");
    content.innerHTML = this.initialTemplate();
    shadow.appendChild(content);

    const intervalId = setInterval(() => {
      this.seconds = this.seconds - 0.01;
      this.shadowRoot.querySelector(".elapsed").textContent =
        this.seconds.toFixed(1);
      if (this.seconds - 0 < 0.001) {
        this.shadowRoot.querySelector("progress").classList.add("expired");
        if (this.stopOnZero) {
          clearInterval(intervalId);
        }
      } else {
        this.shadowRoot.querySelector("progress").value =
          100 - (this.seconds / this.initialSeconds) * 100;
      }
    }, 10);
  }

  _setInitialAttributes() {
    const maybeStopOnZero = this.getAttribute("stop-on-zero");
    if (maybeStopOnZero == null) {
      this.stopOnZero = true;
    } else {
      this.stopOnZero = maybeStopOnZero !== "false";
    }

    const maybeSecondsAttribute = this.getAttribute("seconds");
    const secondsAsInt = parseInt(maybeSecondsAttribute);
    if (maybeSecondsAttribute && !Number.isNaN(secondsAsInt)) {
      this.initialSeconds = secondsAsInt;
      this.seconds = secondsAsInt;
    }
  }

  attributeChangedCallback(name, oldValue, newValue) {
    console.log(
      `Attribute ${name} has changed from ${oldValue} to ${newValue}.`
    );
  }
}

customElements.define("x-countdown", Countdown);
