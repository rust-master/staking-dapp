import React, { useState } from 'react';

const StakeModal = props => {
  const {
    onClose,
    stakeTokenSymbol,
    setStakeTokenQuantity,
    stakeTokens,
  } = props

  return (
    <>
      <div className="modal-class" onClick={onClose}>
        <div className="modal-content" onClick={e => e.stopPropagation()}>
          <div className="modal-body">
            <h2 className="titleHeader">Stake</h2>

            <div className="row">
              <div className="col-md-9 fieldContainer">

                <input
                  className="inputField"
                  placeholder="0.0"
                  onChange={e => props.setStakeTokenQuantity(e.target.value)}
                />
              </div>

              <div className="col-md-3 inputFieldUnitsContainer">
                <span>{stakeTokenSymbol}</span>
              </div>
            </div>

            <div className="row">
              <div
                onClick={() => {stakeTokens(); onClose()}}
                className="pinkButton hoverButton">
                  Stake
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  )
}

export default StakeModal;