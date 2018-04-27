class Script extends React.Component {
  constructor(props) {
    super(props)
    this.state = {lines: this.props.text.split(/\r|\n/), cues: this.props.cues}
    this.findCues=this.findCues.bind(this)
    this.clickedOnMe=this.clickedOnMe.bind(this)
    this.handleAdd=this.handleAdd.bind(this)
  }
  findCues(index) {
    cues=this.state.cues.filter(function(item){
      return item.lineNum===index
    })
    return cues
  }
  clickedOnMe(event, dataOrSomething){
    $("#Cueinput").modal("toggle");
    var element = React.createElement(CueForm, {lineNum : dataOrSomething[0], wordNum : dataOrSomething[1], cues : this.findCues(dataOrSomething[0]), handleClose : this.handleClose, handleAdd : this.handleAdd});
    ReactDOM.render(element, document.getElementById("Cueinput"));
    console.log($(".Cueinput"));
    console.log("WHEN YOURE NOT STROOOOOONG")
    console.log(event);
    console.log(dataOrSomething);

  }
  highlight(line, cue){
    cue = cue.sort(function(a){return a.location});

    str = line.split(" ").map((word)=>
      [word + " ", false]
    );

    for (i = 0; i < cue.length; i++){
      if (cue[i].location < str.length)
        str[cue[i].location][1] = true;
    }
    return str;

  }
  handleClose(){
    ReactDOM.unmountComponentAtNode(document.getElementById("Cueinput"));
  }
  handleAdd(cue){
    ReactDOM.unmountComponentAtNode(document.getElementById("Cueinput"));
    cues = this.state.cues
    indeces = []
    for (i = 0; i < cues.length; i++){
      if (cues[i].location === cue[0].location && cues[i].lineNum === cue[0].lineNum){
        indeces.push(i)
      }
    }
    for (ii = 0; ii < indeces.length; ii++){
      cues.splice(indeces[ii] - ii, 1);
    }
    for (iii = 0; iii < cue.length; iii++){
      cues.push(cue[iii]);
    }

    this.setState({cues: cues})
  }
  render() {
    return <div>
      {this.state.lines.map((line,i)=>
        <p key={i} className={this.findCues(i).length>0 ? "underliner" : ""} >
          {this.highlight(line, this.findCues(i)).map((text, flag)=>
            <tag onClick = {((e) => this.clickedOnMe(e,[i,flag]))}>{text[1] ? <mark> {text} </mark> : text}</tag> 
          )} 
          {this.findCues(i).map((cue,i)=>
            <p key={i} className="cues"> {cue.cueType} {cue.cueLabel} </p>
          )}
        </p>
      )}
      
      <div className="modal" id="Cueinput" tabindex="-1" role="dialog">
        
      </div>
    </div>
  }
}

class CueForm extends React.Component{
  constructor(props){
    super(props)
    var cueCumbersIMeanNumbers = this.props.cues.length > 0 ? [] : [1]//Array.apply(null, Array(n-j)).map(function (_, i) {return i+j;});
    this.state = {cueCumbersIMeanNumbers : cueCumbersIMeanNumbers};
    this.closedForm=this.closedForm.bind(this);
    this.submittingIdeasForHell=this.submittingIdeasForHell.bind(this);
    this.addingCuesToTheScriptThatIsOurLives=this.addingCuesToTheScriptThatIsOurLives.bind(this);
  }

  closedForm(event){
    event.preventDefault();
    $("#Cueinput").modal("toggle");
    console.log("can you log out something in closedForm? sorry i meant after the toggle....im a mean person")
    this.props.handleClose();

  }
  submittingIdeasForHell(event){
    event.preventDefault();
    var cueTypes = [].map.call($(".CueType"), function (type) {
      return type.value
    }
    )
    var cueLabel = [].map.call($(".CueLabel"), function (label) {
      return label.value
    }
    )
    var cueDescription = [].map.call($(".CueDescription"), function (description) {
      return description.value
    }
    )

    console.log("we're in too deep capin!...thats what she said");

    $.ajax({
      method: 'POST',
      url: '/plays/cuesDB',
      dataType: 'JSON',
      data: {
        "cueType[]": cueTypes,
        "cueLabel[]": cueLabel,
        "cueDescription[]": cueDescription,
        location: this.props.wordNum,
        cueLineNum: this.props.lineNum
      },
      success: (result) => {
        console.log("what is your quest, i seek the holy grail, what is your name, i am sir arthur KING OF THE BRITS, what is the average wing speed velocity of an unladen swallow, that depends, african or european, what, i dont...AHHHHHHHHHHH")
        $("#Cueinput").modal("toggle");
        this.props.handleClose();
        this.props.handleAdd(result)

      }
      }).fail((data) => {

    })
  }
  addingCuesToTheScriptThatIsOurLives(event){
    event.preventDefault();
    cueCumbersIMeanNumbers = this.state.cueCumbersIMeanNumbers;
    cueCumbersIMeanNumbers.push(cueCumbersIMeanNumbers.length > 0 ? cueCumbersIMeanNumbers[cueCumbersIMeanNumbers.length - 1] + 1 : this.props.cues.length + 1);
    this.setState({cueCumbersIMeanNumbers: cueCumbersIMeanNumbers});

  }
  render() {
    return <div className="modal-dialog" role="document">
      <div className="modal-content">
        <div className="modal-header">
          <h5 className="modal-title">Cue Details</h5>
          <button type="button" className="close" aria-label="Close" onClick={this.closedForm}>
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div className="modal-body">
          <div id="cueForm">
            {this.props.cues.length > 0 ?
              this.props.cues.reverse().map((cue, i) => 
              <div>
                <h4>Cue #{i + 1} </h4>
                <div className="form-group">
                  <label for="CueType">Cue Type</label>
                  <input defaultValue={cue.cueType} type="text" className="form-control CueType" id="CueType[]" placeholder="e.g. LQ, SQ, etc..."/>
                </div>
                <div className="form-group">
                  <label for="CueLabel">Cue Label</label>
                  <input defaultValue={cue.cueLabel} type="text" className="form-control CueLabel" id="CueLabel[]" placeholder="e.g. 100, A, etc..."/>
                </div>
                <div className="form-group">
                  <label for="CueDescription">Cue Description</label>
                  <input defaultValue={cue.cueDescription} type="text" className="form-control CueDescription" id="CueDescription[]" placeholder="optional"/>
                </div>
              </div>
              ) : 
              this.state.cueCumbersIMeanNumbers.map((i) =>

              <div>
                <h4>Cue #{i} </h4>
                <div className="form-group">
                  <label for="CueType">Cue Type</label>
                  <input type="text" className="form-control CueType" name="CueType[]" placeholder="e.g. LQ, SQ, etc..."/>
                </div>
                <div className="form-group">
                  <label for="CueLabel">Cue Label</label>
                  <input type="text" className="form-control CueLabel" name="CueLabel[]" placeholder="e.g. 100, A, etc..."/>
                </div>
                <div className="form-group">
                  <label for="CueDescription">Cue Description</label>
                  <input type="text" className="form-control CueDescription" name="CueDescription[]" placeholder="optional"/>
                </div>
              </div>
              )
            }
          </div>
          <div className="form-group">
              <button type="button" className="btn btn-dark btn-sm" id="addCue" onClick={this.addingCuesToTheScriptThatIsOurLives}>Add Another Cue</button>
          </div>
        </div>
        <div className="modal-footer">
          <button type="button" className="btn btn-primary" id="submit" onClick={this.submittingIdeasForHell}>Submit</button>
          <button type="button" className="btn btn-secondary" onClick={this.closedForm}>Close</button>
        </div>
      </div>
    </div>
  }
}











